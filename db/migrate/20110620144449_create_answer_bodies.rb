class CreateAnswerBodies < ActiveRecord::Migration
  def self.up
    create_table :answer_bodies do |t|
      t.text :body
      t.text :formatted_html
      t.integer :answer_id

      t.timestamps
    end
    ActiveRecord::Base.connection.execute("INSERT INTO answer_bodies(body, formatted_html, answer_id) SELECT body, formatted_html, id FROM answers")
    remove_column :answers, :body
    remove_column :answers, :formatted_html
  end

  def self.down
    add_column :answers, :formatted_html
    add_column :answers, :body
    ActiveRecord::Base.connection.execute("UPDATE answers, answer_bodies SET answers.body = answer_bodies.body, answers.formatted_html = answers_bodies.formatted_html WHERE answers.id = answer_bodies.answer_id")
    drop_table :answer_bodies
  end
end
