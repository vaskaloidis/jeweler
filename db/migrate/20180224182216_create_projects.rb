class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :language
      t.integer :sprint_total
      t.integer :sprint_current
      t.text :description
      t.string :github_url
      t.string :github_secondary_url
      t.string :readme_file
      t.boolean :readme_remote
      t.string :stage_website_url
      t.string :demo_url
      t.string :prod_url
      t.boolean :complete
      t.string :stage_travis_api_url
      t.string :stage_travis_api_token
      t.string :prod_travis_api_token
      t.string :prod_travis_api_url
      t.string :coveralls_api_url

      t.belongs_to :user, index: true

      t.timestamps
    end

    create_table :project_customers do |pc|
      pc.belongs_to :project, index: true
      pc.belongs_to :user, index:true
    end
  end
end
