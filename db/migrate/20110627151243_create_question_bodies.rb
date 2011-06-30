class CreateQuestionBodies < ActiveRecord::Migration
  def self.up
    create_table :question_bodies do |t|
      t.text :body
      t.text :formatted_html
      t.integer :question_id

      t.timestamps
    end
    ActiveRecord::Base.connection.execute("INSERT INTO question_bodies(body, formatted_html, question_id) SELECT body, formatted_html, id FROM questions")
    remove_column :questions, :body
    remove_column :questions, :formatted_html
  end

  def self.down
    add_column :questions, :formatted_html
    add_column :questions, :body
    ActiveRecord::Base.connection.execute("UPDATE questions, question_bodies SET questions.body = question_bodies.body, questions.formatted_html = question_bodies.formatted_html WHERE questions.id = question_bodies.question_id")
    drop_table :question_bodies
  end
end
