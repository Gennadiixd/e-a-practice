import React from "react";

import HomeSideBar from "../components/SideBar";
import Today from "../containers/Today";
import Feeds from "../containers/Feeds";
import Boards from "../containers/Boards";

const slotsMap = {
  today: Today,
  feeds: Feeds,
  boards: Boards,
};

const Home = () => {
  const [currentTab, setCurrentTab] = React.useState<
    "today" | "feeds" | "boards"
  >("today");

  const ContentSlot = slotsMap[currentTab];

  return (
    <HomeSideBar
      currentTabName={currentTab}
      contentSlot={<ContentSlot />}
      onChangeTab={setCurrentTab}
    />
  );
};

export default Home;
