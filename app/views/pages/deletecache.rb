arr = ['all', 'drugs', 'AskReddit', 'IAmA', 'bestof', 'nba', 'soccer', 'hockey', 'nfl', 'baseball', 'MMA', 'Music', 'GetMotivated', 'LifeProTips', 'food', 'facepalm', 'Jokes', 'pettyrevenge', 'TalesFromRetail', 'DoesAnybodyElse', 'WTF', 'aww', 'cringe', 'cringepics',  'JusticePorn', 'creepyPMs', 'gaming', 'Games', 'movies', 'funny', 'AdviceAnimals', 'pics', 'videos', 'gifs', 'todayilearned', 'science', 'askscience', 'YouShouldKnow', 'explainlikeimfive', 'trees', 'LifeProTips', 'sex', 'Fitness', 'lifehacks', 'politics', 'worldnews', 'news', 'TrueReddit', 'technology', 'Android', 'programming', 'apple', 'dmt', 'startups', 'entrepreneur']
arr.each do |a|
  puts a + " hi"
  Rails.cache.delete("parent_#{a}")
  Rails.cache.delete("comment_#{a}")
  Rails.cache.delete("expire_#{a}")
  Rails.cache.delete("id_#{a}")
end

Rails.cache.delete("parent_imgur")
Rails.cache.delete("comment_imgur")
Rails.cache.delete("expire_imgur")
Rails.cache.delete("id_imgur")
