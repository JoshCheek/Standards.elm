task default: 'build'

desc 'Build the app the app'
task 'build' => ['build/Frontend.html', 'build/Standards.html']

file 'build/Frontend.html'  => 'Frontend.elm'
file 'build/Standards.html' => 'Standards.elm'
file('build/Frontend.html')  { sh "elm --make Frontend.elm" }
file('build/Standards.html') { sh "elm --make Standards.elm" }

desc 'Build and open the app'
task 'open' => 'build' do
  sh "open build/Frontend.html"
end

desc 'Remove files generated in the build'
task 'clean' do
  sh 'rm -r build cache'
end
