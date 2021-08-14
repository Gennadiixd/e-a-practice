import { useQuery } from "@apollo/client";

import { UserFeedsQUERY } from "../graphql/queries";
import useUser from "./use-user";

const useUserFeeds = () => {
  const { id } = useUser();

  const { data } = useQuery(UserFeedsQUERY, {
    variables: {
      id,
    },
  });

  return {
    feeds: data?.user?.feeds || [],
  };
};

export default useUserFeeds;
