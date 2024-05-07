# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(name: "admin", email: "admin@admin.com", password: "123456", kind: :admin)

User.create(name: Faker::Name.name, email: 'email@gmail.com', password: '123456', kind: :instructor)
Academic::Teacher.create(user_id: 2,active: true, sex: "male", birth: "1994-03-08", ethnicity: "Indígena", cpf: "15851701781")

subjects = [
    {    
        active: true,
        name: "Ruby on Rails",
        planning: "Aprenda o basico de RoR de uma forma fascinante.",
        workload: 60,
        leveled: false,
        professionalized: true
    },
    {
        active: true,
        name: "Matematica",
        planning: "Aprenda o basico de todo o conhecimento exato.",
        workload: 90,
        leveled: false
    },
    {
        active: true,
        name: "React Native",
        planning: "Aprenda o basico de React Native de uma forma fascinante.",
        workload: 60,
        leveled: false
    }
]

Academic::Subject.create(subjects)

#############
# Financeiro#
#############




100.times do |i|
    Financial::Account.create!(
        agency: Faker::Bank.account_number(4),
        number: Faker::Bank.account_number(8),
        bank: Faker::Lorem.sentence(3),
        current_value: Faker::Number.decimal(4, 2)
    )

    Financial::Institution.create!(
        name: Faker::Company.name,
        kind: rand(0..1),
        status: rand(0..1)
    )
end

20.times do |i|
    Financial::Project.create!(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
    )
end

20.times do |i|
    Financial::Captation.create!(
        source: Faker::Company.name,
        value: Faker::Number.decimal(3, 2),
        project_id: 1
    )

    Financial::Rubric.create!(
        description: Faker::Lorem.sentence,
        numeration: i+1,
        value: Faker::Number.decimal(3, 2),
        project_id: 1
    )

    Financial::RubricItem.create!(
        numeration: i+1,
        description: Faker::Lorem.paragraph,
        value: Faker::Number.decimal(3, 2),
        rubric_id: 1
    )
end

Financial::TransactionCategory.create!(
    description: "Construção Civil"
)

num = BigDecimal.new(Faker::Number.decimal(3, 2))
Financial::Transaction.create!(
    value: num,
    transaction_date: '2018-12-25',
    account_id: 1,
    transaction_category_id: 1,
    payer_id: 1,
    receiver_id: 1
)

20.times do |i|
    num = BigDecimal.new(Faker::Number.decimal(3, 2))
    Financial::Transaction.create!(
        value: num,
        transaction_date: '2018-12-25',
        transaction_category_id: 1,
        account_id: 1,
        payer_id: 1,
        receiver_id: 1
        )
    end
        
#############
# Secretaria#
#############

School.create(name: "CEFET", number_students: 0)

states = [
    "Acre (AC)",
    "Alagoas (AL)",
    "Amapá (AP)",
    "Amazonas (AM)",
    "Bahia (BA)",
    "Ceará (CE)",
    "Distrito Federal (DF)",
    "Espírito Santo (ES)",
    "Goiás (GO)",
    "Maranhão (MA)",
    "Mato Grosso (MT)",
    "Mato Grosso do Sul (MS)",
    "Minas Gerais (MG)",
    "Pará (PA)",
    "Paraíba (PB)",
    "Paraná (PR)",
    "Pernambuco (PE)",
    "Piauí (PI)",
    "Rio de Janeiro (RJ)",
    "Rio Grande do Norte (RN)",
    "Rio Grande do Sul (RS)",
    "Rondônia (RO)",
    "Roraima (RR)",
    "Santa Catarina (SC)",
    "São Paulo (SP)",
    "Sergipe (SE)",
    "Tocantins (TO)"
]

states.each do |state|
    State.create!(name: state)
end

cities = [
    "Rio de Janeiro",
    "Niterói",
    "Nova Iguaçu",
    "São Gonçalo"
]

cities.each do |city|
    City.create!(name: city, state: State.find_by(name: "Rio de Janeiro (RJ)"))
end

Neighborhood.create(name: "Madureira", city: City.find_by(name: 'Rio de Janeiro'))
Neighborhood.create(name: "Icaraí", city: City.find_by(name: 'Niterói'))


#/*************
#* ACADEMICO *
#*************/

Academic::SchoolYear.create(name: Faker::Name.name, start: Faker::Date.backward, final: Faker::Date.forward, status: :active)
Student.create!(
    name: "Lucas",
    cpf: "75354436052",
    birthdate: "2004-03-26",
    school_id: 1,
    state_id: 1,
    city_id: 1,
    neighborhood_id: 1,
    issuing_date: "2020-05-14",
    sub_neighborhood: "",
    number_residents: 1,
    project_indication_description: "oi",
    year: 2000,
    medication: "tudo que fizer mal faz bem",
    annotations: "nada a declarar",
    nis: "n sei q é",
    sex: 1    )
    Student.create!(
        name: "Canellas",
        cpf: "78189882031",
        birthdate: "2000-03-26",
        school_id: 1,
        state_id: 1,
        city_id: 1,
        neighborhood_id: 1,
        issuing_date: "2020-05-14",
        sub_neighborhood: "",
        number_residents: 1,
        project_indication_description: "oi",
        year: 2000,
        medication: "tudo que fizer mal faz bem",
        annotations: "nada a declarar",
        nis: "n sei q é",
        sex: 1        )
Student.create!(
    name: "Gatto",
    cpf: "99501888061",
    birthdate: "2000-03-26",
    school_id: 1,
    state_id: 1,
    city_id: 1,
    neighborhood_id: 1,
    issuing_date: "2020-05-14",
    sub_neighborhood: "",
    number_residents: 1,
    project_indication_description: "oi",
    year: 2000,
    medication: "tudo que fizer mal faz bem",
    annotations: "nada a declarar",
    nis: "n sei q é",
    sex: 1    )
Student.create!(
    name: "Rossi",
    cpf: "22178910068",
    birthdate: "2000-03-26",
    school_id: 1,
    state_id: 1,
    city_id: 1,
    neighborhood_id: 1,
    issuing_date: "2020-05-14",
    sub_neighborhood: "",
    number_residents: 1,
    project_indication_description: "oi",
    year: 2000,
    medication: "tudo que fizer mal faz bem",
    annotations: "nada a declarar",
    nis: "n sei q é",
    sex: 1    )
Student.create!(
    name: "Ary",
    cpf: "47421432051",
    birthdate: "2000-03-26",
    school_id: 1,
    state_id: 1,
    city_id: 1,
    neighborhood_id: 1,
    issuing_date: "2020-05-14",
    sub_neighborhood: "",
    number_residents: 1,
    project_indication_description: "oi",
    year: 2000,
    medication: "tudo que fizer mal faz bem",
    annotations: "nada a declarar",
    nis: "n sei q é",
    sex: "male"
    )

#Gera presenças aleatórias para todos alunos para testar relatório de faltas
Student.all.each do |student|
    student.presences.each do |presence|
        presence.situation = rand(4)
        presence.save
    end
end



Academic::TeacherSkill.create!(teacher_id: 1, subject_id: '1')
Academic::Classroom.create!(school_year_id: 1, fantasy_name: '2204')
Academic::Inscription.create!(classroom_id: 1, student_id: 1)
Academic::Inscription.create!(classroom_id: 1, student_id: 2)
Academic::Inscription.create!(classroom_id: 1, student_id: 3)
Academic::ClassroomSubject.create!(classroom_id: 1, subject_id: 1,teacher_id: 1, start_time: 'Sat, 01 Jan 2000 14:16:00 -02 -02:00', finish_time: 'Sat, 01 Jan 2000 16:16:00 -02 -02:00', lesson_on_tuesday: true, lesson_on_thursday: true)

Academic::Classroom.create!(school_year_id: 1, fantasy_name: '2077')
Academic::Inscription.create!(classroom_id: 2, student_id: 1, situation: 'approved')
Academic::Inscription.create!(classroom_id: 2, student_id: 2, situation: 'approved')
Academic::Inscription.create!(classroom_id: 2, student_id: 3, situation: 'approved')
Academic::ClassroomSubject.create!(classroom_id: 2, subject_id: 1,teacher_id: 1, start_time: 'Sat, 01 Jan 2000 14:16:00 -02 -02:00', finish_time: 'Sat, 01 Jan 2000 16:16:00 -02 -02:00', lesson_on_tuesday: true, lesson_on_thursday: true)
Academic::ClassroomSubject.create!(classroom_id: 2, subject_id: 2,teacher_id: 1, start_time: 'Sat, 01 Jan 2000 14:16:00 -02 -02:00', finish_time: 'Sat, 01 Jan 2000 16:16:00 -02 -02:00', lesson_on_tuesday: true, lesson_on_thursday: true)
Academic::ClassroomSubject.create!(classroom_id: 2, subject_id: 3,teacher_id: 1, start_time: 'Sat, 01 Jan 2000 14:16:00 -02 -02:00', finish_time: 'Sat, 01 Jan 2000 16:16:00 -02 -02:00', lesson_on_tuesday: true, lesson_on_thursday: true)

# 10.times do
#     user = User.create!(name: Faker::Name.name, password: '123456', email: Faker::Internet.email)
#     Academic::Teacher.create!(user: user, birth: Faker::Date.birthday(18, 65), cpf: '17573808763', sex: [:male, :female].sample)

#     Academic::Subject.create(name: Faker::Lorem.word)
# end

# 10.times do
#     Academic::Classroom.create!(school_year: Academic::SchoolYear.all.sample, fantasy_name: Faker::Lorem.sentence(2))
# end

# 10.times do
#     Academic::TeacherSkill.create(teacher: Academic::Teacher.all.sample, subject: Academic::Subject.all.sample)
# end

# 10.times do
#     Academic::ClassroomSubject.create!(classroom: Academic::Classroom.all.sample, subject: Academic::Subject.all.sample, teacher: Academic::Teacher.all.sample)
# end

