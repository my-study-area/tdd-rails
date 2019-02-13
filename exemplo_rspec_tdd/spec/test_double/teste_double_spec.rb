describe 'Test Double' do
  it 'Double' do
    user = double('User')
    #resumido
    # allow(user).to receive_messages(name: 'Adriano', password: 'secret')
    
    # verboso
    allow(user).to receive(:name).and_return('Jack')
    allow(user).to receive(:password).and_return('secret')
    user.name
    user.password
  end
end
