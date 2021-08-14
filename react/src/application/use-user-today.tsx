import { useQuery } from "@apollo/client";

import { UserTodayQUERY } from "../graphql/queries";
import useUser from "./use-user";

const useUserToday = () => {
  const { id } = useUser();

  const { data } = useQuery(UserTodayQUERY, {
    variables: {
      id,
    },
  });

  return {
    today: data?.user?.Today || [],
  };
};

export default useUserToday;
