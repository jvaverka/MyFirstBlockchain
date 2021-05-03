using Dates
using SHA

struct Block
    id::Int64
    timestamp::DateTime
    previous_hash::String
    data::String
    hash::String
end

function calculate_hash(id::Int64, timestamp::DateTime, previous_hash::String, data::String)
    bytes2hex(sha256(string(id, timestamp, data, previous_hash)))
end

function create_genesis_block()
    time_of_genesis = Dates.now()
    Block(0, time_of_genesis, bytes2hex(sha256("")), "genesis", calculate_hash(0, time_of_genesis, bytes2hex(sha256("")), "genesis"))
end

function next_block(lastblock::Block)
    nextid = lastblock.id + 1
    nexttimestamp = Dates.now()
    nextdata = "Yo! I'm tiny block " * string(nextid)
    nexthash = lastblock.hash
    return Block(nextid, nexttimestamp, nexthash, nextdata, calculate_hash(nextid, nexttimestamp, nexthash, nextdata))
end

let
tinyblockchain = [create_genesis_block()]
previous_block = tinyblockchain[1]

num_of_blocks_to_add = 20

for i in range(1, length=num_of_blocks_to_add)
    block_to_add = next_block(previous_block)
    push!(tinyblockchain, block_to_add)
    previous_block = block_to_add

    # tell everyone
    println("Block $(block_to_add.id) has been added to the tiny blockchain!")
    println("Hash: $(block_to_add.hash)\n")
end
end
