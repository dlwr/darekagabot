class Article < ActiveRecord::Base
  belongs_to :user

  after_create do |article|
    ChangeNotifier.notify_multicast(article)
  end
end
