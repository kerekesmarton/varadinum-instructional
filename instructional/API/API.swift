// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUser($userID: ID!) {
      getUser(_id: $userID) {
        __typename
        id
        name
        email
        workshops {
          __typename
          id
          title
          cover_image_url
        }
      }
    }
    """

  public let operationName: String = "GetUser"

  public var userID: GraphQLID

  public init(userID: GraphQLID) {
    self.userID = userID
  }

  public var variables: GraphQLMap? {
    return ["userID": userID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getUser", arguments: ["_id": GraphQLVariable("userID")], type: .object(GetUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getUser: GetUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getUser": getUser.flatMap { (value: GetUser) -> ResultMap in value.resultMap }])
    }

    public var getUser: GetUser? {
      get {
        return (resultMap["getUser"] as? ResultMap).flatMap { GetUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getUser")
      }
    }

    public struct GetUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("email", type: .nonNull(.scalar(String.self))),
        GraphQLField("workshops", type: .nonNull(.list(.object(Workshop.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, email: String, workshops: [Workshop?]) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "email": email, "workshops": workshops.map { (value: Workshop?) -> ResultMap? in value.flatMap { (value: Workshop) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var workshops: [Workshop?] {
        get {
          return (resultMap["workshops"] as! [ResultMap?]).map { (value: ResultMap?) -> Workshop? in value.flatMap { (value: ResultMap) -> Workshop in Workshop(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Workshop?) -> ResultMap? in value.flatMap { (value: Workshop) -> ResultMap in value.resultMap } }, forKey: "workshops")
        }
      }

      public struct Workshop: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Workshop"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("cover_image_url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, title: String, coverImageUrl: String) {
          self.init(unsafeResultMap: ["__typename": "Workshop", "id": id, "title": title, "cover_image_url": coverImageUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var coverImageUrl: String {
          get {
            return resultMap["cover_image_url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "cover_image_url")
          }
        }
      }
    }
  }
}

public final class GetUsersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUsers {
      getUsers {
        __typename
        id
        name
        email
        workshops {
          __typename
          title
          cover_image_url
        }
      }
    }
    """

  public let operationName: String = "GetUsers"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getUsers", type: .list(.object(GetUser.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getUsers: [GetUser?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getUsers": getUsers.flatMap { (value: [GetUser?]) -> [ResultMap?] in value.map { (value: GetUser?) -> ResultMap? in value.flatMap { (value: GetUser) -> ResultMap in value.resultMap } } }])
    }

    public var getUsers: [GetUser?]? {
      get {
        return (resultMap["getUsers"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetUser?] in value.map { (value: ResultMap?) -> GetUser? in value.flatMap { (value: ResultMap) -> GetUser in GetUser(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetUser?]) -> [ResultMap?] in value.map { (value: GetUser?) -> ResultMap? in value.flatMap { (value: GetUser) -> ResultMap in value.resultMap } } }, forKey: "getUsers")
      }
    }

    public struct GetUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("email", type: .nonNull(.scalar(String.self))),
        GraphQLField("workshops", type: .nonNull(.list(.object(Workshop.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, email: String, workshops: [Workshop?]) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "email": email, "workshops": workshops.map { (value: Workshop?) -> ResultMap? in value.flatMap { (value: Workshop) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var workshops: [Workshop?] {
        get {
          return (resultMap["workshops"] as! [ResultMap?]).map { (value: ResultMap?) -> Workshop? in value.flatMap { (value: ResultMap) -> Workshop in Workshop(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Workshop?) -> ResultMap? in value.flatMap { (value: Workshop) -> ResultMap in value.resultMap } }, forKey: "workshops")
        }
      }

      public struct Workshop: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Workshop"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("cover_image_url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String, coverImageUrl: String) {
          self.init(unsafeResultMap: ["__typename": "Workshop", "title": title, "cover_image_url": coverImageUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var coverImageUrl: String {
          get {
            return resultMap["cover_image_url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "cover_image_url")
          }
        }
      }
    }
  }
}

public final class GetWorkshopQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetWorkshop($workshopID: ID!) {
      getWorkshop(_id: $workshopID) {
        __typename
        id
        title
        cover_image_url
        user {
          __typename
          id
          name
          email
        }
      }
    }
    """

  public let operationName: String = "GetWorkshop"

  public var workshopID: GraphQLID

  public init(workshopID: GraphQLID) {
    self.workshopID = workshopID
  }

  public var variables: GraphQLMap? {
    return ["workshopID": workshopID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getWorkshop", arguments: ["_id": GraphQLVariable("workshopID")], type: .object(GetWorkshop.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getWorkshop: GetWorkshop? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getWorkshop": getWorkshop.flatMap { (value: GetWorkshop) -> ResultMap in value.resultMap }])
    }

    public var getWorkshop: GetWorkshop? {
      get {
        return (resultMap["getWorkshop"] as? ResultMap).flatMap { GetWorkshop(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getWorkshop")
      }
    }

    public struct GetWorkshop: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Workshop"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("cover_image_url", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .nonNull(.object(User.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, title: String, coverImageUrl: String, user: User) {
        self.init(unsafeResultMap: ["__typename": "Workshop", "id": id, "title": title, "cover_image_url": coverImageUrl, "user": user.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var coverImageUrl: String {
        get {
          return resultMap["cover_image_url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "cover_image_url")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String, email: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "email": email])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var email: String {
          get {
            return resultMap["email"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }
      }
    }
  }
}

public final class GetWorkshopsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetWorkshops {
      getWorkshops {
        __typename
        id
        title
        cover_image_url
        user {
          __typename
          id
          name
          email
        }
      }
    }
    """

  public let operationName: String = "GetWorkshops"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getWorkshops", type: .list(.object(GetWorkshop.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getWorkshops: [GetWorkshop?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getWorkshops": getWorkshops.flatMap { (value: [GetWorkshop?]) -> [ResultMap?] in value.map { (value: GetWorkshop?) -> ResultMap? in value.flatMap { (value: GetWorkshop) -> ResultMap in value.resultMap } } }])
    }

    public var getWorkshops: [GetWorkshop?]? {
      get {
        return (resultMap["getWorkshops"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetWorkshop?] in value.map { (value: ResultMap?) -> GetWorkshop? in value.flatMap { (value: ResultMap) -> GetWorkshop in GetWorkshop(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetWorkshop?]) -> [ResultMap?] in value.map { (value: GetWorkshop?) -> ResultMap? in value.flatMap { (value: GetWorkshop) -> ResultMap in value.resultMap } } }, forKey: "getWorkshops")
      }
    }

    public struct GetWorkshop: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Workshop"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("cover_image_url", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .nonNull(.object(User.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, title: String, coverImageUrl: String, user: User) {
        self.init(unsafeResultMap: ["__typename": "Workshop", "id": id, "title": title, "cover_image_url": coverImageUrl, "user": user.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var coverImageUrl: String {
        get {
          return resultMap["cover_image_url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "cover_image_url")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String, email: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "email": email])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var email: String {
          get {
            return resultMap["email"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }
      }
    }
  }
}
