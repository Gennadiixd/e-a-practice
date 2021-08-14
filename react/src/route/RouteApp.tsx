import React from "react";
import { Switch, Route } from "react-router-dom";
import Home from "../pages/Home";
// import PrivateRoute from "./PrivateRoute";
// import PublicRoute from "./PublicRoute";

export default function RouteApp() {
  return (
    <Switch>
      <Route exact path="/" component={Home} />
    </Switch>
  );
}
