class AddGithubRepoNameToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :repo_name, :string
  end
end
