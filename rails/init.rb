if RUBY_VERSION >= "1.9"
  require 'ruby19_monkey'
  Ruby19Monkey.install!
else
  # do nothing
end

