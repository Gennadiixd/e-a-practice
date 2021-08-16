import { useState } from "react";
import { unstable_batchedUpdates } from "react-dom";
import { useCallback } from "react";
import { useApolloClient } from "@apollo/client";

import { UserFeedsQUERY } from "../graphql/queries";

const useFeedsStorage = () => {
  const client = useApolloClient();
  const [userFeeds, setUserFeeds] = useState([]);
  const [status, setStatus] = useState("idle");

  const getUserFeeds = useCallback(async (id: any) => {
    setStatus("loading");

    try {
      const { data } = await client.query({
        query: UserFeedsQUERY,
        variables: {
          id,
        },
      });

      unstable_batchedUpdates(() => {
        setStatus("received");
        setUserFeeds(data?.user?.feeds || []);
      });
    } catch (error) {
      setStatus("error");
    }
  }, []);

  return { getUserFeeds, userFeeds, status };
};

export default useFeedsStorage;
