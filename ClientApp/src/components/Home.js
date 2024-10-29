import React, { useState } from 'react';
import axios from "axios";

export const Home = (props) => {

    const handleLoadClicked = async () => {
        const results = await axios.get("/computer");
        alert(results.data);
    }  

    const handleAddSubmit = async (e) => {
        e.preventDefault();
        const results = await axios.post("/computer");
        alert(results.data);
    }    

    return (
        <div>
            <h1 id="tableLabel">Computer Catalog</h1>
            <button onClick={handleLoadClicked}>Load Data</button>

            <div>Fill out the table below based on your database design</div>
            <table className="table table-striped" aria-labelledby="tableLabel">
                <thead>
                    <tr>
                        <th>Column A</th>
                        <th>Column B</th>
                        <th>Column C</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>11</td>
                        <td>22</td>
                        <td>33</td>
                    </tr>
                    <tr>
                        <td>111</td>
                        <td>222</td>
                        <td>333</td>
                    </tr>
                </tbody>
            </table>

            <div>
                <div>Implement a form to add a row to the table based on your design</div>
                <form onSubmit={handleAddSubmit}>
                    <input></input>
                    <input type="submit" value="Add" />
                </form>
            </div>

        </div>


    );
}