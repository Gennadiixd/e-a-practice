/* eslint-disable no-unused-vars */
import React from "react";
// import { useHistory } from "react-router-dom";
import { PostsContext } from "../Context";
import { Link } from "react-router-dom";
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
  // const history = useHistory();
  const context = React.useContext(PostsContext);

  const [currentTab, setCurrentTab] = React.useState<
    "today" | "feeds" | "boards"
  >("today");
  // React.useEffect(() => {
  //   console.log(context.user.id === "");
  //   if (!context.user.id) {
  //     history.push("/login");
  //   }
  // }, [context]);

  const ContentSlot = slotsMap[currentTab];

  return (
    <>
      {/* <h3>Home</h3>
      Hello {context.user.name}. Your email is {context.user.email}
      <div>
        <Link to={`/user/${context.user.id}`}>My profile</Link>
      </div> */}
      <HomeSideBar
        currentTabName={currentTab}
        contentSlot={<ContentSlot />}
        onChangeTab={setCurrentTab}
      />
    </>
  );
};

export default Home;
