function plotting (option, N_ex, B_1, B_2, y_relaxation_1, y_relaxation_2, time_vector, option_2spin, T, state_1, state_2, phi_t, flag, save)  

        indian_red = "#cd5c5c";    
        teal_color = '#008080';
        x = time_vector (1:length(y_relaxation_1));
        
        if (option == 0 && option_2spin == 0)
            
            values = [2, 40, 80];
            
            if (ismember (T, values) && flag == 24)
                filename = string(T) + 'K_exp.csv';
                table_0 = readtable(filename);
                x_real = table2array(table_0 (:,1));
                y_real = table2array(table_0 (:,2));

                y =  (2 * y_relaxation_1) - N_ex;
                rmin = min(y);                       % value
                rmax = max(y);
                tmax = max(y_real);                  % target
                tmin = min(y_real);

                y_relaxation_1 = (((y - rmin) / (rmax - rmin)) * (tmax-tmin))+ tmin;
                x = time_vector (1:length(y_relaxation_1));
                figure
                plot(x, y_relaxation_1, "x", 'LineWidth', 3);
                hold all
                plot(x_real, y_real, 'LineWidth', 3);
                grid on
                colororder([indian_red; teal_color])
                legend ({"Simulated" ;  "Experimental"}, 'FontSize', 8, 'TextColor', 'black');
                plot_title = string (N_ex) + ' spins at ' + string (T) + 'K (Constant Field: ' + string (B_1(1)) + 'T)';
                title(plot_title)
            
            else
                
                plot(x, y_relaxation_1, 'Color', teal_color)
                legend ("Experimental")
                plot_title = string (N_ex) + ' spins at ' + string (T) + 'K (Constant Field: ' + string (B_1(1)) + 'T)';
                title(plot_title)
            
            end
            
            if (save == 1)
                name = 'Relaxation_' + string(T) + '_exp_constant_field.png';
                saveas(gcf, name)
            end
            
        elseif (option == 1)
            
            colororder([indian_red; teal_color])
            yyaxis left
            ylim([N_ex*0.4 N_ex*0.6])
            plot(x, y_relaxation_1, 'LineWidth', 3)
            ylabel('mu, (a.u.)')
            %xlabel('Time, (ms)')
            
            yyaxis right
            ylim([N_ex*0.4 N_ex*0.6])
            plot (x, B_1*-1000, "--", 'LineWidth', 1.5)
            grid on

            legend ({"Simulated response" ;  "AC field"}, 'FontSize', 8, 'TextColor', 'black');
            plot_title = string (N_ex) + ' spins at ' + string (T) + 'K (Changeable Field)';
            title(plot_title)
            ylabel('Magnetic Field (mT)')
            
            if (save == 1)
                name = 'Relaxation_' + string(T) + '_exp_changeable_field.png';
                saveas(gcf, name)
            end
            
        elseif (option == 0 && option_2spin == 1)
            
            tiledlayout(3,1)
            dark_blue = "#34495e";
            cinnabar_color = "#e74c3c";
            x = time_vector (1:length(state_1));
            
            
            % Top plot
            nexttile
            plot(x, state_1, 'LineWidth', 2);
            hold all
            plot (x, state_2, 'LineWidth', 2);
            colororder([cinnabar_color; dark_blue])
            legend ({"p-bit i" ;  "p-bit j"}, 'FontSize', 8, 'TextColor', 'black','Location','northoutside','Orientation','horizontal');
            ylabel('State')
            grid on
            
            % Middle plot
            nexttile
            x = time_vector (1:length(phi_t));
            plot (x, phi_t, 'LineWidth', 2, 'Color', teal_color);
            ylabel('\Phi')
            grid on

            % Bottom plot
            nexttile
            x = time_vector (1:length(y_relaxation_1));
            plot (x, y_relaxation_1, 'LineWidth', 2);
            hold all
            plot(x, y_relaxation_2, 'LineWidth', 2);
            colororder([cinnabar_color; dark_blue])
            xlabel('Time, (ms)')
            ylabel('mu, (a.u.)')
            grid on
            
            if (save == 1)
                name = 'two p-bits network at ' + string(T) + '.png';
                saveas(gcf, name)
            end
        end    
end
