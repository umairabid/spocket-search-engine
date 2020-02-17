class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_query, against: {
      title: 'A',
      description: 'B',
      tags: 'C'
  }

end
