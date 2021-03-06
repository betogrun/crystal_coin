require "./proof_of_work"

module CrystalCoin
  class Block
    include ProofOfWork

    property current_hash : String
    property index : Int32
    property nonce : Int32
    property previous_hash : String

    def initialize(index = 0, transactions = [] of Transaction, previous_hash = "hash")
      @transactions = transactions
      @index = index
      @timestamp = Time.now
      @previous_hash = previous_hash
      @nonce = proof_of_work
      @current_hash = calc_hash_with_nonce(@nonce)
    end

    def self.first(data="Genesis Block")
      Block.new(previous_hash: "0")
    end

    def self.next(previous_block, transactions = [] of Transaction)
      Block.new(
        transactions: transactions,
        index: previous_block.index + 1,
        previous_hash: previous_block.current_hash
      )
    end
  end
end

blockchain = [ CrystalCoin::Block.first ]
previous_block = blockchain[0]
 5.times do
   new_block = CrystalCoin::Block.next(previous_block: previous_block)
   blockchain << new_block
   previous_block = new_block
 end
 p blockchain
