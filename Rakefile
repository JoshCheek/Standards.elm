file 'build/Standards.html' do
  sh "elm --make Standards.elm"
  sh "open build/Standards.html"
end

file 'Standards.elm' => 'build/Standards.html'
task default: 'Standards.elm'
