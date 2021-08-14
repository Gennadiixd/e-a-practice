import { gql } from "@apollo/client";

export const UserPostInteractionQUERY = gql`
  query User($id: ID!) {
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
  query User($id: ID!) {
    user(id: $id) {
      Today {
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

export const UserFeedsQUERY = gql`
  query User($id: ID!) {
    user(id: $id) {
      Feeds {
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

export const UserBoardsQUERY = gql`
  query User($id: ID!) {
    user(id: $id) {
      Boards {
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