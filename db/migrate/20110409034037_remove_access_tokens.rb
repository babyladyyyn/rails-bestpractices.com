class RemoveAccessTokens < ActiveRecord::Migration
  def self.up
    drop_table :access_tokens
  end

  def self.down
  end
end
