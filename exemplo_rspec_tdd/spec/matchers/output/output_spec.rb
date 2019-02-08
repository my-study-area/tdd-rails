describe 'Matcher Output' do
  it { expect { puts "adriano"}.to output.to_stdout }
  it { expect { print "adriano" }.to output("adriano").to_stdout }
  it { expect { puts "adriano avelino" }.to output(/adriano/).to_stdout }

  it { expect { warn "adriano" }.to output.to_stderr }
  it { expect { warn "adriano" }.to output("adriano\n").to_stderr }
  it { expect { warn "adriano" }.to output(/adriano/).to_stderr }
end
