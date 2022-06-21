class GraphqlRequest {
  final String login = """
  mutation(\$identifier: String!, \$password: String!) {
  login(input: { identifier: \$identifier, password: \$password }) {
    jwt
    user {
      email
    }
  }
}
  """;
  final String me = """
  query {
  me {
    email,
    role{name}
  }
}
  """;

  final String publicData = """
query GetFestivalsNotFinished {
  festivals(filters: { date_end: { gte: "2022-05-04" } }) {
    data {
      id,
      attributes {
        name,
        date_start,
        date_end,
        localisation,
        stands {
          data {
            attributes {
              name

              passages {
                data {
                  attributes {
                    artist {
                      data {
                        attributes {
                          name
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

  """;
  final String createFestival = """
mutation(
  \$name: String!
  \$date_start: Date!
  \$date_end: Date!
  \$localisation: String!
) {
  createFestival(
    data: {
      name: \$name
      date_start: \$date_start
      date_end: \$date_end
      localisation: \$localisation
    }
  ) {
    data {
      id
    }
  }
}
  """;
  final String editFestival = """
mutation(
  \$id: ID!
  \$name: String!
  \$date_start: Date!
  \$date_end: Date!
  \$localisation: String!
) {
  updateFestival(
    id: \$id
    data: {
      name: \$name
      date_start: \$date_start
      localisation: \$localisation
      date_end: \$date_end
    }
  ) {
    data {
      id
    }
  }
}

  """;
  final String deleteFestival = """
mutation(\$id: ID!) {
  deleteFestival(id: \$id) {
    data {
      id
    }
  }
}
  """;

  final String getAllArtiste = """
query GetAllArtistes {
  artists {
    data {
      id
      attributes {
        name
        description
      }
    }
  }
}

  """;
  final String createArtiste = """
mutation(
  \$name: String!
  \$description: String!
) {
  createArtist(
    data: {
      name: \$name
      description: \$description
      sitemap_exclude: false
    }
  ) {
    data {
      id
    }
  }
}


  """;
  final String editArtiste = """
mutation(
  \$id: ID!
  \$name: String!
  \$description: String!
) {
  updateArtist(
    id: \$id
    data: {
      name: \$name
      description: \$description
    }
  ) {
    data {
      id
    }
  }
}


  """;
  final String deleteArtiste = """
mutation(\$id: ID!) {
  deleteArtist(id: \$id) {
    data {
      id
    }
  }
}


  """;

  final String getAllStands = """
query GetAllStands {
  stands {
    data {
      id
      attributes {
        name
        position
        festival {
          data {
            id
          }
        }
      }
    }
  }
}


  """;
  final String getFestivalForStand = """
query getFestivalForStand {
  festivals {
    data {
      id
      attributes {
        name
      }
    }
  }
}

  """;
  final String createStands = """
mutation(
  \$name: String!
  \$position: String!
  \$festival :ID!
) {
  createStand(
    data: {
      name: \$name
      position: \$position
      festival: \$festival
      sitemap_exclude: false
    }
  ) {
    data {
      id
    }
  }
}


  """;
  final String editStands = """
mutation(\$id: ID!, \$name: String!, \$position: String!, \$festival: ID!) {
  updateStand(
    id: \$id
    data: { name: \$name, position: \$position, festival: \$festival }
  ) {
    data {
      id
    }
  }
}



  """;
  final String deleteStands = """
mutation(\$id: ID!) {
  deleteStand(id: \$id) {
    data {
      id
    }
  }
}


  """;

  // \

  final String getAllPassages = """
query GetAllPassages {
  passages {
    data {
      id
      attributes {
        date_start
        duration
        stand {
          data {
            id
            attributes {
              name
            }
          }
        }
        artist {
          data {
            id
            attributes {
              name
            }
          }
        }
      }
    }
  }
}

  """;

}
