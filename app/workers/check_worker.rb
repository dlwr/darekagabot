class CheckWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false, unique: :until_executed

  recurrence { minutely.second_of_minute(0,30) }

  def perform
    ArticleChecker.check
  end
end
