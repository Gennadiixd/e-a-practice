import React, { FC, useEffect } from "react";
import useUserFeeds from "../application/use-user-feeds";
import Feed from "../components/Feed";

const Feeds: FC = () => {
  const { feeds, getUserFeeds } = useUserFeeds();

  useEffect(() => {
    getUserFeeds();
  }, []);

  return (
    <main>
      {feeds.map((feed: any) => (
        <Feed feed={feed} key={feed.id} />
      ))}
    </main>
  );
};

export default Feeds;
