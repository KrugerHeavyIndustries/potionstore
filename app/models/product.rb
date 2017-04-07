class Product < ActiveRecord::Base
  normalize_attributes :image_path
end
