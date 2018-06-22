# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

######## LINK CATEGORIES #########
link_website = LinkCategory.create(title: 'website')
link_wikipedia = LinkCategory.create(title: 'wikipedia')
link_rss_feed = LinkCategory.create(title: 'rss_feed')
link_mooc = LinkCategory.create(title: 'mooc')
link_facebook = LinkCategory.create(title: 'facebook')
link_twitter = LinkCategory.create(title: 'twitter')
link_instagram = LinkCategory.create(title: 'instagram')
link_youtube = LinkCategory.create(title: 'youtube')
link_linkedin = LinkCategory.create(title: 'linkedin')

######## CODE CATEGORIES #########
code_uai = CodeCategory.create(title: 'uai')
code_siret = CodeCategory.create(title: 'siret')
code_grid = CodeCategory.create(title: 'grid')
code_eter = CodeCategory.create(title: 'eter')
code_wikidata = CodeCategory.create(title: 'wikidata')
code_orgref = CodeCategory.create(title: 'orgref')
code_isni = CodeCategory.create(title: 'isni')
code_funding_data = CodeCategory.create(title: 'funding_data')
code_naf = CodeCategory.create(title: 'naf')

##### CONNECTION CATEGORIES ######
connection_composante_juridique = InstitutionConnectionCategory.create(title: 'Composante juridique')
InstitutionConnectionCategory.create(title: 'Annexe Géographique')
InstitutionConnectionCategory.create(title: 'Filière ou département ou Section')
InstitutionConnectionCategory.create(title: 'Sans objet')
InstitutionConnectionCategory.create(title: 'Ne sait pas')
InstitutionConnectionCategory.create(title: 'Quelque soit le type de rattachement')
connection_siege_composante = InstitutionConnectionCategory.create(title: 'siege_composante')
connection_comue = InstitutionConnectionCategory.create(title: 'comue')
connection_association = InstitutionConnectionCategory.create(title: 'association')

###### EVOLUTION CATEGORIES ######
InstitutionEvolutionCategory.create(title: 'fusion')
InstitutionEvolutionCategory.create(title: 'eclatement')

######### TAG CATEGORIES #########
InstitutionTagCategory.create(title: 'groupe zone uai', origin: 'bcn')
InstitutionTagCategory.create(title: 'ministere tutelle', origin: 'bcn')
InstitutionTagCategory.create(title: 'secteur public prive', origin: 'bcn')
InstitutionTagCategory.create(title: 'etablissement_type', origin: 'bcn')
InstitutionTagCategory.create(title: 'etablissement_type2', origin: 'bcn')
InstitutionTagCategory.create(title: 'etablissement_type3', origin: 'bcn')
InstitutionTagCategory.create(title: 'universite_typologie', origin: 'bcn')
InstitutionTagCategory.create(title: 'catégorie juridique', origin: 'bcn')
InstitutionTagCategory.create(title: 'catégorie siege', origin: 'bcn')
InstitutionTagCategory.create(title: 'qualification', origin: 'bcn')
InstitutionTagCategory.create(title: 'statut_operateur_lolf', origin: 'bcn')

############## TAG ###############
InstitutionTag.create(short_label: "GEO", long_label: "Regroupement géographique", institution_tag_category_id: 1)
InstitutionTag.create(short_label: "MEN", long_label: "Regroupement Ministère de l'éducation", institution_tag_category_id: 1)
InstitutionTag.create(short_label: "VILLE", long_label: "Regroupement économique et social", institution_tag_category_id: 1)
InstitutionTag.create(short_label: "MEN SUP", long_label: "Regroupement Enseignement supérieur", institution_tag_category_id: 1)
InstitutionTag.create(short_label: "MEN 1D", long_label: "Regroupement MEN pour les écoles", institution_tag_category_id: 1)
InstitutionTag.create(short_label: "ENS SUP", long_label: "enseignement superieur", institution_tag_category_id: 2)
tag_educ_nat = InstitutionTag.create(short_label: "EDUC NAT", long_label: "ministere de l'education nationale", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "EXTERIEUR", long_label: "relations exterieures", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "CULTURE", long_label: "culture", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "ANC COMBAT", long_label: "anciens combattants", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "TOURISME", long_label: "tourisme", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "TOM", long_label: "territoires d outre mer", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "INTERIEUR", long_label: "interieur et decentralisation", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "1ER MINIST", long_label: "premier ministre", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "RECHERCHE", long_label: "recherche et technologie", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "PLAN", long_label: "plan et amenagement du territoire", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "DOM", long_label: "departements d outre mer", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "LOGEMENT", long_label: "urbanisme logement", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "TRANSPORTS", long_label: "transports", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "JEUNESSE", long_label: "jeunesse et sports", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "SANTE", long_label: "sante et solidarite nationale", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "ENVIRON", long_label: "environnement", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "POSTES", long_label: "postes et telecommunications", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "DEFENSE", long_label: "defense", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "SANS TUTEL", long_label: "sans tutelle", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "INDUSTRIE", long_label: "redeploiement industriel", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "MER", long_label: "mer", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "COOPERAT.", long_label: "cooperation et developpement", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "TRAVAIL", long_label: "travail emploi formation professionnelle", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "QQS MINIST", long_label: "quelque soit le ministere", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "AGRICULTUR", long_label: "agriculture", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "JUSTICE", long_label: "justice", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "ECONOMIE", long_label: "economie finances et budget", institution_tag_category_id: 2)
InstitutionTag.create(short_label: "COMMERCE", long_label: "commerce et artisanat", institution_tag_category_id: 2)
tag_public = InstitutionTag.create(short_label: "PUBLIC", long_label: "secteur public", institution_tag_category_id: 3)
tag_private = InstitutionTag.create(short_label: "PRIVE", long_label: "secteur prive", institution_tag_category_id: 3)
InstitutionTag.create(short_label: "TYPO10", long_label: "Universités scientifiques et/ou médicales", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "TYPO21", long_label: "Universités pluridisciplinaires avec santé", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "TYPO22", long_label: "Universités pluridisciplinaires hors santé", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "TYPO31", long_label: "Universités tertiaires - lettres et sc. Humaines", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "TYPO32", long_label: "Universités tertiaires - droit et économie", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "TYPO99", long_label: "Communautés d'universités et établissements", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "IUFM", long_label: "Instituts universitaires de formation des maîtres", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "ESPE", long_label: "Écoles supérieures du professorat et de l'éducation", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "UT", long_label: "Universités de technologie", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "IPINP", long_label: "Instituts polytechniques", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "ECENTRALE", long_label: "Écoles centrales", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "ENI", long_label: "Écoles nationales d'ingénieurs", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "ENSCHIMIE", long_label: "Écoles nationales supérieures de chimie", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "ENSI", long_label: "École nationale supérieure d'ingénieurs", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "INSA", long_label: "Instituts nationaux de sciences appliquées", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "INGAUTRE", long_label: "Autres écoles d'ingénieurs", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "ENS", long_label: "Écoles normales supérieures", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "IEP", long_label: "Instituts d'études politiques", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "AUTRE", long_label: "Autres établissements", institution_tag_category_id: 4)
InstitutionTag.create(short_label: "Communauté d'universités et établissements", long_label: "Communauté d'universités et établissements", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "ENS", long_label: "École normale supérieure", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "École supérieure du professorat", long_label: "École supérieure du professorat et de l'éducation", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Écoles habilitées à délivrer un diplôme d'ingénieur", long_label: "Écoles habilitées à délivrer un diplôme d'ingénieur", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Écoles nationales supérieures d'ingénieurs", long_label: "Écoles nationales supérieures d'ingénieurs", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "EPSCP", long_label: "Établissements d'enseignement supérieur privés rattachés à un EPSCP", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Grand établissement", long_label: "Grand établissement", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Institut national polytechnique", long_label: "Institut national polytechnique", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "IUFM", long_label: "Institut universitaire de formation des maîtres", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Instituts et écoles extérieurs aux universités", long_label: "Instituts et écoles extérieurs aux universités", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Université", long_label: "Université", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Autre établissement", long_label: "Autre établissement", institution_tag_category_id: 5)
InstitutionTag.create(short_label: "Université", long_label: "Université", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "École d'ingénieurs", long_label: "École d'ingénieurs", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Grand établissement", long_label: "Grand établissement", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Autre établissement", long_label: "Autre établissement", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Communauté d'universités et établissements", long_label: "Communauté d'universités et établissements", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Instituts et écoles extérieurs aux universités", long_label: "Instituts et écoles extérieurs aux universités", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Grand établissement relevant d'un autre département ministériel", long_label: "Grand établissement relevant d'un autre département ministériel", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Écoles nationales supérieures d'ingénieurs", long_label: "Écoles nationales supérieures d'ingénieurs", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "IEP", long_label: "Institut d'étude politique", institution_tag_category_id: 6)
tag_business_school = InstitutionTag.create(short_label: "", long_label: "École de commerce et de management", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Établissement privé d'enseignement universitaire", long_label: "Établissement privé d'enseignement universitaire", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Association d'établissements", long_label: "Association d'établissements", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "École française à l'étranger", long_label: "École française à l'étranger", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "EPSCP", long_label: "Etablissement relevant d'un autre département ministériel rattaché à un EPSCP", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "ENS", long_label: "École normale supérieure", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "EPSCP", long_label: "Établissements d'enseignement supérieur privés rattachés à un EPSCP", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Établissement supérieur d'architecture", long_label: "Établissement supérieur d'architecture", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Institut national polytechnique", long_label: "Institut national polytechnique", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Pôle de recherche et d'enseignement supérieur", long_label: "Pôle de recherche et d'enseignement supérieur", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "École extérieure relevant d'un autre département ministériel", long_label: "École extérieure relevant d'un autre département ministériel", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Écoles habilitées à délivrer un diplôme d'ingénieur", long_label: "Écoles habilitées à délivrer un diplôme d'ingénieur", institution_tag_category_id: 6)
InstitutionTag.create(short_label: "Université pluridisciplinaire avec santé", long_label: "Université pluridisciplinaire avec santé", institution_tag_category_id: 7)
InstitutionTag.create(short_label: "Université pluridisciplinaire hors santé", long_label: "Université pluridisciplinaire hors santé", institution_tag_category_id: 7)
InstitutionTag.create(short_label: "Université tertiaire - lettres et sc. Humaines", long_label: "Université tertiaire - lettres et sc. Humaines", institution_tag_category_id: 7)
InstitutionTag.create(short_label: "Université scientifique et/ou médicale", long_label: "Université scientifique et/ou médicale", institution_tag_category_id: 7)
InstitutionTag.create(short_label: "Université tertiaire - droit et économie", long_label: "Université tertiaire - droit et économie", institution_tag_category_id: 7)
InstitutionTag.create(short_label: "EPCS", long_label: "etablt public cooperation scientifique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "FCS", long_label: "fondation de cooperation scientifique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GIE", long_label: "groupement d'interet economique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "ETAT", long_label: "service de l etat", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "REGION", long_label: "service de region", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "DEPART", long_label: "service de departement", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "COMMUNE", long_label: "service communal", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "INTERCOM", long_label: "service intercommunal", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPLE", long_label: "etablt public local d enseignement", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPA", long_label: "etablt public a caractere administratif", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPA RATT", long_label: "epa ens sup ratt a epcscp l719-10 l721-1", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPTEA", long_label: "etablt public territorial enseignement", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPU SPEC", long_label: "etablt public a statut particulier", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPSCP", long_label: "epcscp et.pub.car.scient.culturel.prof.", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPST", long_label: "etab pub car.scientifique et technique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPIC", long_label: "etab pub car.industriel et commercial", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "CCI", long_label: "etablt public consulaire c.c.i.", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EC.METIERS", long_label: "ecole de metiers", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GIP", long_label: "groupement d interet public", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "S.ASSOCIAT", long_label: "service d'une association", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "S.ENT.PRIV", long_label: "service d'une entreprise privee", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "UFR", long_label: "unite formation et recherche l.713-3 & 4", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GERE EPLE", long_label: "gere par un eple", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GERE C.C.I", long_label: "gere par la cci", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "CH METIERS", long_label: "etablt public consulaire chambre metiers", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GERE CM", long_label: "gere par la chambre des metiers", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "CH AGRICUL", long_label: "etablt public consulaire agriculture", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GERE C AGR", long_label: "gere par la chambre d agriculture", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "SS PERS JU", long_label: "sans personnalite juridique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "SANS OBJET", long_label: "sans objet", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "ENTR PUB", long_label: "gere par une entreprise publique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "TOM", long_label: "service territorial", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GD ETAB", long_label: "epcscp grand etablissement l.717-1", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "ECOLE EXT", long_label: "epcscp ecole externe a universite l715-1", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPCSCP", long_label: "epcscp l.712-1 l.716-1 l.718-1", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "ECOLE INT", long_label: "ecole institut interne universite l713-9", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "SERV COM", long_label: "service commun l.714-1 l.714-2", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "DEPART", long_label: "departement labo ctre recherche l.713-1", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "INT GD ETB", long_label: "structure interne grand etablissement", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "ASSOC", long_label: "association", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "FONDATION", long_label: "fondation privee rec. d'utilite publique", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPR RATT", long_label: "etab prive ens sup ratt a epcscp l719-10", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "EPA N.RATT", long_label: "epa ens sup non ratt a epcscp l.741-1", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "SERV GENE", long_label: "services generaux d'universite d.95-550", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "GERE GIP", long_label: "gere par un gip", institution_tag_category_id: 8)
InstitutionTag.create(short_label: "siege", long_label: "siege", institution_tag_category_id: 9)
InstitutionTag.create(short_label: "non_siege", long_label: "non_siege", institution_tag_category_id: 9)
InstitutionTag.create(short_label: "Établissement d’enseignement supérieur privé d’intérêt général", long_label: "Établissement d’enseignement supérieur privé d’intérêt général", institution_tag_category_id: 10)
InstitutionTag.create(short_label: "Opérateurs MIRES", long_label: "Opérateurs MIRES 2014", institution_tag_category_id: 11)
InstitutionTag.create(short_label: "on_Opérateur_LOLF", long_label: "Non_Opérateur_LOLF_2014", institution_tag_category_id: 11)
InstitutionTag.create(short_label: "Opérateurs LOLF Hors MIRE", long_label: "Opérateurs LOLF Hors MIRES 2014", institution_tag_category_id: 11)
InstitutionTag.create(short_label: "Opérateurs MIRES", long_label: "Opérateurs MIRES 2015", institution_tag_category_id: 11)

########## INSTITUTIONS ##########
# univ_paris = Institution.create(date_start: 100.years.ago)
# InstitutionName.create(text: 'Université de Paris',
#                        initials: 'UP',
#                        institution_id: univ_paris.id)
#
#
#
# hec = Institution.create(date_start: 50.years.ago)
# InstitutionName.create(text: 'HEC',
#                        initials: 'HEC',
#                        institution_id: hec.id)
# Address.create(business_name: 'HEC',
#                address_1: '1 Rue de la Libération',
#                address_2: '',
#                zip_code: '78350',
#                city: 'Jouy-en-Josas',
#                country: 'France',
#                phone: '01 39 67 70 00',
#                latitude: 48.757887,
#                longitude: 2.1694163,
#                date_start: 50.years.ago,
#                date_end: '',
#                addressable_id: hec.id,
#                addressable_type: Institution)
# Code.create(content: '0783054W', code_category_id: code_uai.id, institution_id: hec.id)
# InstitutionConnection.create(mother_id: univ_paris.id, daughter_id: hec.id, institution_connection_category_id: connection_siege_composante.id)
# Link.create(content: 'http://www.hec.fr/', link_category_id: link_website.id, institution_id: hec.id)
# Link.create(content: 'http://www.twitter.com/hecparis', link_category_id: link_twitter.id, institution_id: hec.id)
# Link.create(content: 'http://www.linkedin.com/edu/hec-paris-12443', link_category_id: link_linkedin.id, institution_id: hec.id)
# Link.create(content: 'http://www.facebook.com/HECParis', link_category_id: link_facebook.id, institution_id: hec.id)
# Link.create(content: 'http://www.instagram.com/hec_paris', link_category_id: link_instagram.id, institution_id: hec.id)
# Link.create(content: 'http://www.youtube.com/channel/UCOlxIv6pqgiCpdiaFXxLmNw', link_category_id: link_youtube.id, institution_id: hec.id)
# InstitutionTagging.create(institution_id: hec.id, institution_tag_id: tag_private.id)
# InstitutionTagging.create(institution_id: hec.id, institution_tag_id: tag_business_school.id)
# InstitutionTagging.create(institution_id: hec.id, institution_tag_id: tag_educ_nat.id)

#
# sorbonne = Institution.create(date_start: 38.years.ago)
# InstitutionName.create(text: 'Université Paris Sorbonne',
#                        initials: 'Paris IV',
#                        institution_id: sorbonne.id)
# Address.create(business_name: 'Sorbonne',
#                address_1: '1 Rue des Ecoles',
#                address_2: '',
#                zip_code: '75005',
#                city: 'Paris',
#                country: 'France',
#                phone: '01 40 46 22 11',
#                latitude: 48.8479781,
#                longitude: 2.3438391,
#                date_start: 50.years.ago,
#                date_end: '',
#                addressable_id: sorbonne.id,
#                addressable_type: Institution)
# Code.create(content: '0752756N', code_category_id: code_uai.id, institution_id: sorbonne.id)
# InstitutionConnection.create(mother_id: univ_paris.id, daughter_id: sorbonne.id, institution_connection_category_id: connection_siege_composante.id)
# Link.create(content: 'http://www.paris-sorbonne.fr/', link_category_id: link_website.id, institution_id: sorbonne.id)
# Link.create(content: 'https://fr.wikipedia.org/wiki/Sorbonne_Universit%C3%A9', link_category_id: link_wikipedia.id, institution_id: sorbonne.id)
# InstitutionTagging.create(institution_id: sorbonne.id, institution_tag_id: tag_public.id)
# InstitutionTagging.create(institution_id: hec.id, institution_tag_id: tag_educ_nat.id)
#
#
#
# centrale = Institution.create(date_start: 63.years.ago)
# InstitutionName.create(text: 'CentraleSupelec',
#                        initials: 'ECS',
#                        institution_id: centrale.id)
# Address.create(business_name: 'CentraleSupelec',
#                address_1: '3 Rue Joliot Curie',
#                address_2: '',
#                zip_code: '91190',
#                city: 'Gif-sur-Yvette',
#                country: 'France',
#                phone: '01 69 85 12 12',
#                latitude: 48.7088206,
#                longitude: 2.1639495,
#                date_start: 50.years.ago,
#                date_end: '',
#                addressable_id: centrale.id,
#                addressable_type: Institution)
# Code.create(content: '0752756N', code_category_id: code_uai.id, institution_id: centrale.id)
# InstitutionConnection.create(mother_id: univ_paris.id, daughter_id: centrale.id, institution_connection_category_id: connection_siege_composante.id)
# Link.create(content: 'http://www.centralesupelec.fr/', link_category_id: link_website.id, institution_id: centrale.id)
# Link.create(content: 'Wikipedia', link_category_id: link_wikipedia.id, institution_id: centrale.id)
# InstitutionTagging.create(institution_id: centrale.id, institution_tag_id: tag_private.id)
# InstitutionTagging.create(institution_id: hec.id, institution_tag_id: tag_educ_nat.id)
