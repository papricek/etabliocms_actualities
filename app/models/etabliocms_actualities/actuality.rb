module EtabliocmsActualities
  class Actuality < ActiveRecord::Base
    default_scope :order => "updated_at desc"

    scope :recent, lambda { |limit| {:limit => limit, :order => "updated_at desc"} }
    scope :last_edited, lambda { |limit| {:limit => limit, :order => "updated_at desc"} }
    scope :visible, lambda { where(["(publish_date < ? AND unpublish_date > ?) ", Time.now, Time.now]) }
    scope :last_week, lambda { where(['created_at > ? and created_at < ?', 7.days.ago, Time.now]) }

    validates :title, :presence => true
    validates :publish_date, :presence => true
    validates :unpublish_date, :presence => true

    has_slug :to_param => :id_slug

    def summary
      self.perex.present? ? self.perex : self.text
    end

  end
end
