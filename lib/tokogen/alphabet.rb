# frozen_string_literal: true
module Tokogen
  module Alphabet
    BASE62 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a).join.freeze
    BASE58 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a - %w(0 O I l)).join.freeze
    BASE64 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['+', '/']).join.freeze

    # Note: This is NOT ASCII85 coding alphabet, it's from RFC1924.
    # Do not use in unless you're sure you need it!
    BASE85 = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['!', '#', '$', '%', '&', '(', ')', '*', '+', '-', ';', '<', '=', '>', '?', '@', '^', '_', '`', '{', '|', '}', '~']).join.freeze

    # Some simple alphabets.
    # Mainly used for testing but you can use them too.
    BASE2 = ('0'..'1').to_a.join.freeze
    BASE3 = ('0'..'2').to_a.join.freeze
  end
end
