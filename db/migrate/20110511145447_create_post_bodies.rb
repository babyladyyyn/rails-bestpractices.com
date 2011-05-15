class CreatePostBodies < ActiveRecord::Migration
  def self.up
    create_table :post_bodies do |t|
      t.text :body
      t.text :formatted_html
      t.integer :post_id

      t.timestamps
    end
    ActiveRecord::Base.connection.execute("INSERT INTO post_bodies(body, formatted_html, post_id) SELECT body, formatted_html, id FROM posts")
    remove_column :posts, :body
    remove_column :posts, :formatted_html
  end

  def self.down
    add_column :posts, :formatted_html, :text
    add_column :posts, :body, :text
    ActiveRecord::Base.connection.execute("UPDATE posts, post_bodies SET posts.body = post_bodies.body, posts.formatted_html = post_bodies.formatted_html WHERE posts.id = post_bodies.post_id")
    drop_table :post_bodies
  end
end
