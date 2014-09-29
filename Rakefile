task default: 'build'

desc 'Build the app the app'
task 'build' => 'Frontend.elm'

file 'Frontend.elm' => 'build/Frontend.html'
file 'build/Frontend.html' do
  sh "elm --make Frontend.elm"
end

desc 'Build and open the app'
task 'open' => 'build' do
  sh "open build/Frontend.html"
end
