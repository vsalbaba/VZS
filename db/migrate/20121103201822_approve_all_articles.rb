class ApproveAllArticles < ActiveRecord::Migration
  def up
    puts "Approving articles:"
    Article.all.each do |article|
      puts "id #{article.id}..."
      article.approved = true
      article.save!
    end
  end

  def down
  end
end
