# frozen_string_literal: true
module Tokogen
  module Alphabet
    BASE62 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a).join.freeze
    BASE58 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a - ['0', 'O', 'I', 'l']).join.freeze
    BASE64 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['+', '/']).join.freeze
  end
end
