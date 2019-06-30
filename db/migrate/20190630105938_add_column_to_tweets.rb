class AddColumnToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column  :tweets, :steps, :integer 
  end
end
