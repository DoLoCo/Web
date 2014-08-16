if Rails.env.production?
  Balanced.configure(ENV['BALANCED_PAYMENTS_MARKETPLACE_KEY'])
else
  Balanced.configure('ak-test-2q80HU8DISm2atgm0iRKRVIePzDb34qYp')
end