class Turn < ApplicationRecord
  belongs_to :frame, inverse_of: :turns

end
