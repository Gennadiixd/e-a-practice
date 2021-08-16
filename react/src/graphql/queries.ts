import { gql } from "@apollo/client";

// export const UserPostInteractionQUERY = gql`
//   query userPostInteractions($id: ID!) {
//     user(id: $id) {
//       UserPostInteraction {
//         id
//         isPostHidden
//         isPostPostponed
//         isPostRead
//         Post {
//           id
//         }
//       }
//     }
//   }
// `;

export const UserTodayQUERY = gql`
  query userToday($id: ID!) {
    user(userId: $id) {
      firstName
      # Today {
      #   id
      #   Posts
      # }
    }
  }
`;

export const UserFeedsQUERY = gql`
  query userFeeds($id: ID!) {
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
  query userBoards($id: ID!) {
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
