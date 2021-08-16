import useFeedsStorage from "../services/FeedsStorageAdaptor";
import useUser from "./use-user";

const useUserFeeds = () => {
  const { id } = useUser();
  const { getUserFeeds, userFeeds } = useFeedsStorage();

  const handleGetUserFeeds = () => {
    getUserFeeds(id);
  };

  return { feeds: userFeeds, getUserFeeds: handleGetUserFeeds };
};

export default useUserFeeds;
