user = User.find_or_create_by(
  {email: "johnsmithuser3210@gmail.com", full_name: "John Smith", uid: "112231986933189792844", avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocJAs7Ep4cZOhJLcmLGoZEtGRBDA0rU2YkzVyEmfbmFl=s96-c", is_admin: true, user_first_name: "John", user_last_name: "Smith", user_contact_email: "johnsmithuser3210@gmail.com", user_ph_num: "5555555555", user_class_year: 1955, user_job_field: "Job", user_location: "City", user_status: "Alumni", user_major: "Aggie"}
)
