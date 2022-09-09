FILEPATH = 'words/google-10000-english-no-swears.txt'

file = File.open(FILEPATH, 'r')
words = []
until file.eof?
  line = file.readline
  words = words.push(line)
end
