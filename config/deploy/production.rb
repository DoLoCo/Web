role :app, %w{deploy@72.14.182.62}
role :web, %w{deploy@72.14.182.62}
role :db,  %w{deploy@72.14.182.62}

server '72.14.182.62', user: 'deploy', roles: %w{web app db}