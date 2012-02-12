class Group < ActiveRecord::Base
	has_many :users
    has_many :articles

    attr_accessible :name, :ident

    # skupiny jsou pevne definovany
    # existuji 4 urovne registrovanych uzivatelu:
    #
    # ID | ident    | name
    # 1  | outsider | Nečlen
    # 2  | member   | Člen
    # 3  | board    | Výbor
    # 4  | admin    | Administrátor
end
