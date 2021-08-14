import { gql } from "@apollo/client";

export const UserPostInteractionQUERY = gql`
  query user($id: ID!) {
    user(id: $id) {
      UserPostInteraction {
        id
        isPostHidden
        isPostPostponed
        isPostRead
        Post {
          id
        }
      }
    }
  }
`;

export const UserTodayQUERY = gql`
  query user($id: ID!) {
    user(id: $id) {
      Today {
        id
        Posts
      }
    }
  }
`;

export const UserFeedsQUERY = gql`
  query user($id: ID!) {
    user(userId: $id) {
      feeds {
        id
        title
        authors {
          id
          title
          description
        }
      }
    }
  }
`;

export const UserBoardsQUERY = gql`
  query user($id: ID!) {
    user(userId: $id) {
      boards {
        id
        title
        description
        posts {
          id
          title
          textContent
        }
      }
    }
  }
`;
