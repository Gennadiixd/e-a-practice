import { useQuery } from "@apollo/client";

import { UserPostInteractionQUERY } from "../graphql/queries";
import useUser from "./use-user";

const useUserPostsInteractions = () => {
  const { id } = useUser();

  const { data } = useQuery(UserPostInteractionQUERY, {
    variables: {
      id,
    },
  });

  return {
    userPostsInteractions: data?.user?.UserPostInteraction || [],
  };
};

export default useUserPostsInteractions;
