class User < ApplicationRecord
        before_save{self.email.downcase!}
    validates:name,presence:true,length:{maximum:50}
   validates :email,presence:true,length:{maximum:255},
                    format:{with:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                    uniqueness:{case_sensitive:false}
    
    has_secure_password
    
    has_one :profile,:dependent => :destroy
    has_one :photo,:dependent => :destroy
    has_many :files
    has_many :topics 
    has_many :messages
    # ユーザーがお気に入りに登録しているトピック
    has_many :topic_favorites,class_name: 'Favorite'
    # お気に入りに登録されているトピック
    has_many :favorite_item,through: :topic_favorites,source: :topic
    has_many :favorites
    # お気に入りユーザー
    has_many :friends
   
    #ユーザーがフォローしているもの 
    has_many :followings,through: :friends,source: :follow
    has_many :reverses_of_relationship,class_name: 'Friend',foreign_key: 'follow_id'
    has_many :followers,through: :reverses_of_relationship,source: :user
    
    has_many :topic_histories,class_name: 'History'
    has_many :users_show_item,through: :topic_histories,source: :topic
    has_many :historys, class_name: 'History'
    
    # ================================================================
    
    def include_favo?(rand_id)
        self.topic_favorites.exists?(topic_id: rand_id)
    end
    
    # =============================================
    def follow(other_user)
        unless self == other_user
        self.friends.find_or_create_by(follow_id: other_user)
        end
    end
    
    def unfollow(other_user)
        friend = self.friends.find_by(follow_id: other_user.id)
        friend.destroy if friend
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
end
