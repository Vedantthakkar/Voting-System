struct Voter:
    weight: int128
    voted: bool
    delegate: address
    vote: int128

struct Proposal:
    name: bytes32
    voteCount: int128

voters: public(map(address, Voter))
proposals: public(map(int128, Proposal))
voterCount: public(int128)
chairperson: public(address)
int128Proposals: public(int128)


@public
@constant
def delegated(addr: address) -> bool:
    return self.voters[addr].delegate != ZERO_ADDRESS


@public
@constant
def directlyVoted(addr: address) -> bool:
    return self.voters[addr].voted and (self.voters[addr].delegate == ZERO_ADDRESS)


@public
def __init__(_proposalNames: bytes32[2]):
    self.chairperson = msg.sender
    self.voterCount = 0
    for i in range(2):
        self.proposals[i] = Proposal({
            name: _proposalNames[i],
            voteCount: 0
        })
        self.int128Proposals += 1

@public
def giveRightToVote(voter: address):
    assert msg.sender == self.chairperson
    assert not self.voters[voter].voted
    assert self.voters[voter].weight == 0
    self.voters[voter].weight = 1
    self.voterCount += 1

@public
def forwardWeight(delegate_with_weight_to_forward: address):
    assert self.delegated(delegate_with_weight_to_forward)
    assert self.voters[delegate_with_weight_to_forward].weight > 0

    target: address = self.voters[delegate_with_weight_to_forward].delegate
    for i in range(4):
        if self.delegated(target):
            target = self.voters[target].delegate
            assert target != delegate_with_weight_to_forward
        else:
            break

    weight_to_forward: int128 = self.voters[delegate_with_weight_to_forward].weight
    self.voters[delegate_with_weight_to_forward].weight = 0
    self.voters[target].weight += weight_to_forward

    if self.directlyVoted(target):
        self.proposals[self.voters[target].vote].voteCount += weight_to_forward
        self.voters[target].weight = 0

    
@public
def delegate(to: address):
    assert not self.voters[msg.sender].voted
    assert to != msg.sender
    assert to != ZERO_ADDRESS

    self.voters[msg.sender].voted = True
    self.voters[msg.sender].delegate = to

    self.forwardWeight(msg.sender)

@public
def vote(proposal: int128):
    assert not self.voters[msg.sender].voted
    assert proposal < self.int128Proposals

    self.voters[msg.sender].vote = proposal
    self.voters[msg.sender].voted = True
    self.proposals[proposal].voteCount += self.voters[msg.sender].weight
    self.voters[msg.sender].weight = 0

@public
@constant
def winningProposal() -> int128:
    winning_vote_count: int128 = 0
    winning_proposal: int128 = 0
    for i in range(2):
        if self.proposals[i].voteCount > winning_vote_count:
            winning_vote_count = self.proposals[i].voteCount
            winning_proposal = i
    return winning_proposal

@public
@constant
def winnerName() -> bytes32:
    return self.proposals[self.winningProposal()].name
)})