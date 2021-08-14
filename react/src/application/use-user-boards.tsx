import { useQuery } from "@apollo/client";

import { UserBoardsQUERY } from "../graphql/queries";
import useUser from "./use-user";

const useUserBoard = () => {
  const { id } = useUser();

  const { data } = useQuery(UserBoardsQUERY, {
    variables: {
      id,
    },
  });

  return {
    boards: data?.user?.boards || [],
  };
};

export default useUserBoard;
