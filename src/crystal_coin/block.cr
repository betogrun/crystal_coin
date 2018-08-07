require "openssl"

module CrystalCoin
  class Block
    property current_hash : String
    property index : Int32

    def initialize(index = 0, data = "data", previous_hash = "hash")
      @data = data
      @index = index
      @timestamp = Time.now
      @previous_hash = previous_hash
      @current_hash = hash_block
    end

    def self.first(data="Genesis Block")
      Block.new(data: data, previous_hash: "0")
    end

    def self.next(previous_block, data = "Transaction Data")
      Block.new(
        data: "Transaction data numer (#{previous_block.index + 1})",
        index: previous_block.index + 1,
        previous_hash: previous_block.current_hash
      )
    end

    private def hash_block
      hash = OpenSSL::Digest.new("SHA256")
      hash.update("#{@index}#{@timestamp}#{@data}#{@previous_hash}")
      hash.hexdigest
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