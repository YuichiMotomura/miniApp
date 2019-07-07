class RenameStepsColumnToTweets < ActiveRecord::Migration[5.2]
  def change
    rename_column :tweets, :steps, :minutes
  end
end
