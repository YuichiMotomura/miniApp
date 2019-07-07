class AddColumnToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column  :tweets, :calorie, :integer
  end
end
