module EtabliocmsActualities
  class Category < ActiveRecord::Base

    has_many :actualities, :dependent => :nullify

    acts_as_nested_set
    attr_accessor :child_of
    after_save :update_position

    validates :title, :presence => true
    validates :locale, :presence => true

    has_slug :to_param => "path"

    def path
      self_and_ancestors.map(&:slug).join("/")
    end

    def other_categories_for_select
      categories = EtabliocmsActualities::Category.order("lft ASC")
      categories = categories.where("id != ?", id) unless new_record?
      categories.map { |d| [d.title, d.id] }
    end

    scope :for_locale, lambda { |locale| where(:locale => locale) }

    private
    def update_position
      if child_of.to_i != parent_id.to_i
        if child_of.present?
          parent = Category.find(child_of)
          move_to_child_of parent unless parent == self or parent == self.parent
          move_to_bottom
        elsif !child_of.nil?
          move_to_root
          move_to_bottom
        end
      end
      self.child_of = nil
    end

  end
end
